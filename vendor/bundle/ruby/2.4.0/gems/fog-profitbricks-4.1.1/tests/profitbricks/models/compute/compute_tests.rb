Shindo.tests('Fog::Compute[:profitbricks] | compute models', %w(profitbricks compute)) do
  compute = Fog::Compute.new(:provider => 'ProfitBricks', :profitbricks_username => ENV['PROFITBRICKS_USERNAME'], :profitbricks_password => ENV['PROFITBRICKS_PASSWORD'])

  tests('success') do
    Excon.defaults[:connection_timeout] = 500
    tests('List Contract Resources').succeeds do
      contract_resources = compute.contract_resources.all

      contract_resources.count > 0 &&
        contract_resources[0].contract_number !~ /\D/
    end

    tests('List Requests').succeeds do
      requests = compute.requests.all
      @request_id = requests[0].id

      requests.count > 0 &&
        requests[0].type == 'request'
    end

    tests('Get Request').succeeds do
      request = compute.requests.get(@request_id)

      request.id == @request_id &&
        request.type == 'request'
    end

    tests('Get Request Status').succeeds do
      request_status = compute.requests.get_status(@request_id)

      request_status.id == "#{@request_id}/status" &&
        request_status.type == 'request-status'
    end

    tests('List Locations').succeeds do
      locations = compute.locations.all

      locations.count > 0 &&
        locations[0].type == 'location' &&
        locations.find {|item| item.id == 'us/las'} != nil
    end

    tests('Get Location').succeeds do
      location = compute.locations.get('us/las')

      location.id == 'us/las' &&
        location.type == 'location'
    end

    tests('Create Datacenter Simple').succeeds do
      datacenter = compute.datacenters.create(:name => 'Fog Test',
                                              :location => 'us/las',
                                              :description => 'Fog test datacenter')
      datacenter.wait_for {ready?}

      @datacenter_id = datacenter.id

      datacenter.type == 'datacenter' &&
        datacenter.name == 'Fog Test' &&
        datacenter.location == 'us/las' &&
        datacenter.description == 'Fog test datacenter'
    end

    tests('Create Datacenter Composite').succeeds do
      servers = [
        {
          name: 'Fog Test',
          ram: 1024,
          cores: 1
        }
      ]

      volumes = [
        {
          name: 'Fog Test',
          size: 2,
          bus: 'VIRTIO',
          type: 'HDD',
          licenceType: 'UNKNOWN',
          availabilityZone: 'ZONE_3'
        }
      ]
      datacenter = compute.datacenters.create(:name => 'Fog Test Composite',
                                              :location => 'us/las',
                                              :description => 'Fog test composite datacenter',
                                              :servers => servers,
                                              :volumes => volumes)
      datacenter.wait_for {ready?}

      @composite_dc_id = datacenter.id

      datacenter.type == 'datacenter' &&
        datacenter.name == 'Fog Test Composite' &&
        datacenter.location == 'us/las' &&
        datacenter.description == 'Fog test composite datacenter' &&
        datacenter.servers.count > 0 &&
        datacenter.volumes.count > 0
    end

    tests('List Datacenters').succeeds do
      datacenters = compute.datacenters.all

      datacenters.count > 0 &&
        datacenters[0].type == 'datacenter'
    end

    tests('Get Datacenter').succeeds do
      datacenter = compute.datacenters.get(@datacenter_id)

      datacenter.id == @datacenter_id &&
        datacenter.type == 'datacenter' &&
        datacenter.name == 'Fog Test' &&
        datacenter.location == 'us/las' &&
        datacenter.description == 'Fog test datacenter'
    end

    tests('Update Datacenter').succeeds do
      datacenter = compute.datacenters.get(@datacenter_id)
      datacenter.name = datacenter.name + ' - RENAMED'
      datacenter.update
      datacenter.wait_for {ready?}
      datacenter.reload

      datacenter.name == 'Fog Test - RENAMED' &&
        datacenter.version > 1
    end

    tests('Create LAN').succeeds do
      lan = compute.lans.create(:datacenter_id => @datacenter_id,
                                :name => 'Fog Test',
                                :public => true)

      @lan_id = lan.id
      sleep(120) if ENV["FOG_MOCK"] != "true"

      lan.name == 'Fog Test' &&
        lan.public
    end

    tests('List LANs').succeeds do
      lans = compute.lans.all(@datacenter_id)

      lans.count > 0 &&
        lans[0].type == 'lan'
    end

    tests('Get LAN').succeeds do
      lan = compute.lans.get(@datacenter_id, @lan_id)

      lan.id == @lan_id &&
        lan.type == 'lan' &&
        lan.name == 'Fog Test' &&
        lan.public
    end

    tests('Update LAN').succeeds do
      lan = compute.lans.get(@datacenter_id, @lan_id)
      lan.name = lan.name + ' - RENAME'
      lan.public = false
      lan.update

      lan.id == @lan_id &&
        lan.type == 'lan' &&
        lan.name == 'Fog Test - RENAME'
    end

    tests('List Images').succeeds do
      images = compute.images.all

      images.count > 0
      images[0].type == 'image'

      image = images.find do |img|
        img.image_type == 'HDD' &&
          img.licence_type == 'LINUX' &&
          img.location == 'us/las'
      end

      @image_id = image.id
    end


    tests('Get Image').succeeds do
      image = compute.images.get(@image_id)

      image.id == @image_id &&
        image.type == 'image' &&
        !image.name.empty? &&
        image.description.to_s.empty? &&
        !image.location.to_s.empty? &&
        image.size > 0 &&
        ['true', 'false', true, false].include?(image.cpu_hot_plug) &&
        ['true', 'false', true, false].include?(image.cpu_hot_unplug) &&
        ['true', 'false', true, false].include?(image.ram_hot_plug) &&
        ['true', 'false', true, false].include?(image.ram_hot_unplug) &&
        ['true', 'false', true, false].include?(image.nic_hot_plug) &&
        ['true', 'false', true, false].include?(image.nic_hot_unplug) &&
        ['true', 'false', true, false].include?(image.disc_virtio_hot_plug) &&
        ['true', 'false', true, false].include?(image.disc_virtio_hot_unplug) &&
        ['true', 'false', true, false].include?(image.disc_scsi_hot_plug) &&
        ['true', 'false', true, false].include?(image.disc_scsi_hot_unplug) &&
        ['true', 'false', true, false].include?(image.public) &&
        !image.licence_type.to_s.empty? &&
        !image.image_type.to_s.empty?
    end

    tests('Create Volume').succeeds do
      volume = compute.volumes.create(:datacenter_id => @datacenter_id,
                                      :name => 'Fog Test',
                                      :size => 2,
                                      :bus => 'VIRTIO',
                                      :type => 'HDD',
                                      :availability_zone => 'ZONE_3',
                                      :image => @image_id,
                                      :ssh_keys => ['ssh-rsa AAAAB3NzaC1'])
      volume.wait_for {ready?}

      @volume_id = volume.id

      volume.name == 'Fog Test' &&
        volume.size == 2 &&
        volume.bus == 'VIRTIO' &&
        volume.type == 'HDD' &&
        volume.availability_zone == 'ZONE_3' &&
        volume.image == @image_id &&
        volume.ssh_keys.kind_of?(Array)
    end

    tests('List Volumes').succeeds do
      volumes = compute.volumes.all(@datacenter_id)

      volumes.count > 0 &&
        volumes[0].type == 'HDD'
    end

    tests('Get Volume').succeeds do
      volume = compute.volumes.get(@datacenter_id, @volume_id)

      volume.id == @volume_id &&
        volume.name == 'Fog Test' &&
        volume.size == 2 &&
        volume.type == 'HDD' &&
        volume.availability_zone == 'ZONE_3' &&
        volume.image == @image_id
    end

    tests('Update Volume').succeeds do
      volume = compute.volumes.get(@datacenter_id, @volume_id)
      volume.size = 5
      volume.name = volume.name + ' - RENAME'
      volume.update

      volume.wait_for {ready?}
      volume.reload

      volume.id == @volume_id &&
        volume.name == 'Fog Test - RENAME' &&
        volume.size == 5
    end

    tests('Create Snapshot').succeeds do
      volume = compute.volumes.get(@datacenter_id, @volume_id)

      volume.create_snapshot('Fog Test', 'Fog test snapshot') == true
      volume.reload
    end

    tests('List Snapshots').succeeds do
      sleep(30) if ENV["FOG_MOCK"] != "true"

      snapshots = compute.snapshots.all
      snapshot = snapshots.find do |snp|
        snp.name == 'Fog Test'
      end

      @snapshot_id = snapshot.id

      snapshots.count > 0 &&
        snapshots[0].type == 'snapshot'
    end

    tests('Get Snapshot').succeeds do
      volume = compute.volumes.get(@datacenter_id, @volume_id)
      snapshot = compute.snapshots.get(@snapshot_id)

      snapshot.id == @snapshot_id &&
        snapshot.name == 'Fog Test' &&
        snapshot.description.include?('Fog') &&
        snapshot.type == 'snapshot' &&
        snapshot.location == 'us/las' &&
        snapshot.size == volume.size &&
        snapshot.cpu_hot_plug == volume.cpu_hot_plug &&
        snapshot.cpu_hot_unplug == volume.cpu_hot_unplug &&
        snapshot.ram_hot_plug == volume.ram_hot_plug &&
        snapshot.ram_hot_unplug == volume.ram_hot_unplug &&
        snapshot.nic_hot_plug == volume.nic_hot_plug &&
        snapshot.nic_hot_unplug == volume.nic_hot_unplug &&
        snapshot.disc_virtio_hot_plug == volume.disc_virtio_hot_plug &&
        snapshot.disc_virtio_hot_unplug == volume.disc_virtio_hot_unplug &&
        snapshot.disc_scsi_hot_plug == volume.disc_scsi_hot_plug &&
        snapshot.disc_scsi_hot_unplug == volume.disc_scsi_hot_unplug &&
        snapshot.licence_type == volume.licence_type
    end

    tests('Restore Snapshot').succeeds do
      volume = compute.volumes.get(@datacenter_id, @volume_id)

      volume.restore_snapshot(@snapshot_id)
    end

    tests('Update Snapshot').succeeds do
      snapshot = compute.snapshots.get(@snapshot_id)

      snapshot.name = snapshot.name + ' - RENAME'
      snapshot.description = snapshot.description + ' - RENAME'
      snapshot.update

      sleep(30) if ENV["FOG_MOCK"] != "true"
      snapshot = compute.snapshots.get(@snapshot_id)

      snapshot.name == 'Fog Test - RENAME' &&
        snapshot.description.include?('Fog') &&
        snapshot.description.include?('- RENAME')
    end

    tests('Create Server').succeeds do
      server = compute.servers.create(:datacenter_id => @datacenter_id,
                                      :name => 'Fog Test',
                                      :ram => 1024,
                                      :cores => 1,
                                      :availability_zone => 'ZONE_1',
                                      :cpu_family => 'INTEL_XEON')
      server.wait_for {ready?}

      @server_id = server.id

      server.type == 'server' &&
        server.name == 'Fog Test' &&
        server.ram == 1024 &&
        server.cores == 1 &&
        server.availability_zone == 'ZONE_1' &&
        server.cpu_family == 'INTEL_XEON'
    end

    tests('Create Server Composite').succeeds do
      volumes = [
        {
          name: 'Fog Test',
          size: 2,
          bus: 'VIRTIO',
          type: 'HDD',
          licence_type: 'UNKNOWN',
          availability_zone: 'ZONE_3'
        }
      ]
      nics = [
        {
          name: 'Fog Test',
          dhcp: 'true',
          lan: 1,
          firewallActive: true,
          nat: false,
          firewallrules: [
            {
              name: 'SSH',
              protocol: 'TCP',
              sourceMac: '01:23:45:67:89:00',
              portRangeStart: 22,
              portRangeEnd: 22
            }
          ]
        }
      ]

      server = compute.servers.create(:datacenter_id => @datacenter_id,
                                      :name => 'Fog Test Composite',
                                      :ram => 1024,
                                      :cores => 1,
                                      :volumes => volumes,
                                      :nics => nics)
      server.wait_for {ready?}

      @composite_server_id = server.id

      server.type == 'server' &&
        server.name == 'Fog Test Composite' &&
        server.ram == 1024 &&
        server.cores == 1 &&
        server.nics.count > 0 &&
        server.volumes.count > 0
    end

    tests('List Servers').succeeds do
      servers = compute.servers.all(@datacenter_id)

      servers.count > 0 &&
        servers[0].type == 'server'
    end

    tests('Get Server').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      server.id == @server_id &&
        server.type == 'server' &&
        server.name == 'Fog Test' &&
        server.cores == 1 &&
        server.ram == 1024 &&
        server.availability_zone == 'ZONE_1' &&
        server.cpu_family == 'INTEL_XEON'
    end

    tests('Update Server').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      server.name = server.name + ' RENAME'
      server.update

      server.wait_for {ready?}

      server.id == @server_id &&
        server.name == 'Fog Test RENAME'
    end

    tests('Attach Volume').succeeds do
      volume = compute.attach_volume(@datacenter_id, @server_id, @volume_id)

      sleep(60) if ENV["FOG_MOCK"] != "true"

      volume.body['id'] == @volume_id &&
        volume.body['properties']['name'] == 'Fog Test - RENAME' &&
        volume.body['properties']['size'] == 5 &&
        volume.body['properties']['type'] == 'HDD' &&
        volume.body['properties']['licenceType'] == 'LINUX'
    end

    tests('List Attached Volumes').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      volumes = server.list_volumes

      volumes['items'].count > 0
    end

    tests('Get Attached Volume').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      volume = server.get_attached_volume(@volume_id)

      volume['name'] == 'Fog Test - RENAME' &&
        volume['size'] == 5 &&
        volume['bus'] == 'VIRTIO' &&
        volume['type'] == 'HDD'
    end

    tests('Detach Volume').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      server.detach_volume(@volume_id)
    end

    tests('Attach CDROM').succeeds do
      images = compute.images.all
      cd_image = images.find do |img|
        img.image_type == 'CDROM' &&
          img.licence_type == 'LINUX'
      end
      @cd_image_id = cd_image.id

      server = compute.servers.get(@datacenter_id, @server_id)
      sleep(30) if ENV["FOG_MOCK"] != "true"

      cdrom = server.attach_cdrom(@cd_image_id)
      sleep(120) if ENV["FOG_MOCK"] != "true"

      @cdrom_id = cdrom['id']

      cdrom['id'] == @cd_image_id &&
        !cdrom['name'].to_s.empty?
    end

    tests('List Attached CDROMs').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      server.list_cdroms.count > 0
    end

    if ENV["FOG_MOCK"] == "true"
      tests('Get Attached CDROM').succeeds do
        server = compute.servers.get(@datacenter_id, @server_id)

        cdrom = server.get_attached_cdrom(@cdrom_id)

        cdrom['id'] == @cdrom_id &&
          !cdrom['name'].empty?
      end
    end

    tests('Detach CDROM').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      if !server.list_cdroms['items'].empty?
        server.detach_cdrom(@image_id)
      else
        server.list_cdroms
      end
    end

    tests('Stop Server').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      server.stop
    end

    tests('Start Server').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      server.stop
    end

    tests('Reset Server').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)

      server.reboot
    end

    tests('Reserve IP Block').succeeds do
      ip_block = compute.ip_blocks.create(:location => 'us/las',
                                          :size => 2,
                                          :name => 'Fog Test')

      sleep(60) if ENV["FOG_MOCK"] != "true"

      @ip_block_id = ip_block.id

      ip_block.name == 'Fog Test' &&
        ip_block.size == 2 &&
        ip_block.location == 'us/las'
    end

    tests('List IP Blocks').succeeds do
      ip_blocks = compute.ip_blocks.all

      ip_blocks.count > 0 &&
        ip_blocks[0].type == 'ipblock'
    end

    tests('Get IP Block').succeeds do
      ip_block = compute.ip_blocks.get(@ip_block_id)

      ip_block.id == @ip_block_id &&
        ip_block.type == 'ipblock' &&
        ip_block.name == 'Fog Test' &&
        ip_block.size == 2 &&
        ip_block.location == 'us/las' &&
        ip_block.ips.count == 2
    end

    tests('Create NIC').succeeds do
      sleep(60) if ENV["FOG_MOCK"] != "true"
      nic = compute.nics.create(:datacenter_id => @datacenter_id,
                                :server_id => @composite_server_id,
                                :lan => @lan_id,
                                :name => 'Fog Test',
                                :dhcp => true,
                                :firewall_active => true,
                                :ips => ['10.0.0.1'],
                                :nat => false)
      nic.type == 'nic' &&
        nic.name == 'Fog Test' &&
        nic.lan.to_s == @lan_id.to_s &&
        nic.firewall_active &&
        nic.ips.is_a?(Array)
    end

    tests('List NICs').succeeds do
      nics = compute.nics.all(@datacenter_id, @composite_server_id)

      @nic_id = nics[0].id

      nics.count > 0 &&
        nics[0].type == 'nic'
    end

    tests('Get NIC').succeeds do
      nic = compute.nics.get(@datacenter_id, @composite_server_id, @nic_id)

      nic.id == @nic_id &&
        nic.type == 'nic' &&
        nic.name == 'Fog Test' &&
        nic.dhcp &&
        nic.lan.to_s == @lan_id.to_s &&
        nic.ips.is_a?(Array)
    end

    tests('Update NIC').succeeds do
      nic = compute.nics.get(@datacenter_id, @composite_server_id, @nic_id)
      nic.name = nic.name + ' - RENAME'
      nic.update

      nic.name == 'Fog Test - RENAME'
    end

    tests('Create Firewall Rule').succeeds do
      firewall_rule = compute.firewall_rules.create(:datacenter_id => @datacenter_id,
                                                    :server_id => @composite_server_id,
                                                    :nic_id => @nic_id,
                                                    :name => 'SSH',
                                                    :protocol => 'TCP',
                                                    :source_mac => '01:23:45:67:89:00',
                                                    :port_range_start => '22',
                                                    :port_range_end => '22')

      sleep(60) if ENV["FOG_MOCK"] != "true"

      @firewall_rule_id = firewall_rule.id

      firewall_rule.type == 'firewall-rule' &&
        firewall_rule.name == 'SSH' &&
        firewall_rule.protocol == 'TCP' &&
        firewall_rule.source_mac == '01:23:45:67:89:00' &&
        firewall_rule.source_ip.nil? &&
        firewall_rule.target_ip.nil? &&
        firewall_rule.port_range_start.to_s == '22' &&
        firewall_rule.port_range_end.to_s == '22' &&
        firewall_rule.icmp_type.nil? &&
        firewall_rule.icmp_code.nil?
    end

    tests('List Firewall Rules').succeeds do
      firewall_rules = compute.firewall_rules.all(@datacenter_id, @composite_server_id, @nic_id)

      firewall_rules.count > 0 &&
        firewall_rules[0].type == 'firewall-rule'
    end

    tests('Get Firewall Rule').succeeds do
      firewall_rule = compute.firewall_rules.get(@datacenter_id, @composite_server_id, @nic_id, @firewall_rule_id)

      firewall_rule.id == @firewall_rule_id &&
        firewall_rule.type == 'firewall-rule' &&
        firewall_rule.name == 'SSH' &&
        firewall_rule.protocol == 'TCP' &&
        firewall_rule.source_mac == '01:23:45:67:89:00' &&
        firewall_rule.source_ip.nil? &&
        firewall_rule.target_ip.nil? &&
        firewall_rule.port_range_start.to_s == '22' &&
        firewall_rule.port_range_end.to_s == '22' &&
        firewall_rule.icmp_type.nil? &&
        firewall_rule.icmp_code.nil?
    end

    tests('Create Load Balancer').succeeds do
      load_balancer = compute.load_balancers.create(:datacenter_id => @datacenter_id,
                                                    :name => 'Fog Test',
                                                    :dhcp => true)

      sleep(60) if ENV["FOG_MOCK"] != "true"

      @load_balancer_id = load_balancer.id

      load_balancer.type == 'loadbalancer' &&
        load_balancer.name == 'Fog Test' &&
        load_balancer.dhcp
    end

    tests('List Load Balancers').succeeds do
      load_balancers = compute.load_balancers.all(@datacenter_id)

      load_balancers.count > 0 &&
        load_balancers[0].type == 'loadbalancer'
    end

    tests('Get Load Balancer').succeeds do
      load_balancer = compute.load_balancers.get(@datacenter_id, @load_balancer_id)

      load_balancer.id == @load_balancer_id &&
        load_balancer.type == 'loadbalancer' &&
        load_balancer.name == 'Fog Test' &&
        load_balancer.dhcp == true
    end

    tests('Update Load Balancer').succeeds do
      load_balancer = compute.load_balancers.get(@datacenter_id, @load_balancer_id)
      load_balancer.name = load_balancer.name + ' - RENAME'
      load_balancer.update

      sleep(60) if ENV["FOG_MOCK"] != "true"

      load_balancer.id == @load_balancer_id &&
        load_balancer.type == 'loadbalancer' &&
        load_balancer.name == 'Fog Test - RENAME'
    end

    tests('Associate Balanced NIC').succeeds do
      load_balancer = compute.load_balancers.get(@datacenter_id, @load_balancer_id)
      nic = load_balancer.associate_nic(@nic_id)

      sleep(60) if ENV["FOG_MOCK"] != "true"

      nic['id'] == @nic_id &&
        nic['name'] == 'Fog Test - RENAME'
    end

    tests('List Balanced NICs').succeeds do
      load_balancer = compute.load_balancers.get(@datacenter_id, @load_balancer_id)
      balanced_nics = load_balancer.list_nics

      balanced_nics.count > 0 &&
        balanced_nics[0]['type'] == 'nic'
    end

    tests('Get Balanced NIC').succeeds do
      load_balancer = compute.load_balancers.get(@datacenter_id, @load_balancer_id)
      balanced_nic = load_balancer.get_nic(@nic_id)

      balanced_nic['id'].to_s == @nic_id.to_s &&
        balanced_nic['type'] == 'nic' &&
        balanced_nic['name'] == 'Fog Test - RENAME' &&
        ((balanced_nic['mac'] =~ /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/) == 0) &&
        balanced_nic['ips'].count > 0 &&
        ['true', 'false', true, false].include?(balanced_nic['nat'])
    end

    tests('List Resources').succeeds do
      resources = compute.resources.all

      datacenter = resources.find do |r|
        r.type == 'datacenter'
      end

      image = resources.find do |r|
        r.type == 'image'
      end

      snapshot = resources.find do |r|
        r.type == 'snapshot'
      end

      ipblock = resources.find do |r|
        r.type == 'ipblock'
      end

      @dc_id = datacenter.id
      @img_id = image.id
      @snp_id = snapshot.id
      @ipb_id = ipblock.id

      resources.count > 0
    end

    tests('List Datacenter Resources').succeeds do
      resources = compute.resources.get_by_type('datacenter')

      resources.count > 0 &&
        resources[0].type == 'datacenter'
    end

    tests('List Image Resources').succeeds do
      resources = compute.resources.get_by_type('image')

      resources.count > 0 &&
        resources[0].type == 'image'
    end

    tests('List Snapshot Resources').succeeds do
      resources = compute.resources.get_by_type('snapshot')

      resources.count > 0 &&
        resources[0].type == 'snapshot'
    end

    tests('List IP Block Resources').succeeds do
      resources = compute.resources.get_by_type('ipblock')

      resources.count > 0 &&
        resources[0].type == 'ipblock'
    end

    tests('Get Datacenter Resource').succeeds do
      resource = compute.resources.get_resource_by_type('datacenter', @dc_id)

      resource.id == @dc_id &&
        resource.type == 'datacenter'
    end

    tests('Get Image Resource').succeeds do
      resource = compute.resources.get_resource_by_type('image', @img_id)

      resource.id == @img_id &&
        resource.type == 'image'
    end

    tests('Get Snapshot Resource').succeeds do
      resource = compute.resources.get_resource_by_type('snapshot', @snp_id)

      resource.id == @snp_id &&
        resource.type == 'snapshot'
    end

    tests('Get IP Block Resource').succeeds do
      resource = compute.resources.get_resource_by_type('ipblock', @ipb_id)

      resource.id == @ipb_id &&
        resource.type == 'ipblock'
    end
  end

  tests('user management success') do
    Excon.defaults[:connection_timeout] = 500

    tests('Create Group').succeeds do
      group = compute.groups.create(:name => 'Fog Test',
                                    :create_datacenter => true,
                                    :create_snapshot => true,
                                    :reserve_ip => true,
                                    :access_activity_log => true)
      group.wait_for {ready?}

      @group_id = group.id

      group.type == 'group' &&
        group.name == 'Fog Test' &&
        group.create_datacenter == true &&
        group.create_snapshot == true &&
        group.reserve_ip == true &&
        group.access_activity_log == true
    end

    tests('List Groups').succeeds do
      groups = compute.groups.all

      groups.count > 0 &&
        groups[0].type = 'group'
    end

    tests('Get Group').succeeds do
      group = compute.groups.get(@group_id)

      group.id == @group_id &&
        group.type == 'group' &&
        group.name == 'Fog Test' &&
        group.create_datacenter == true &&
        group.create_snapshot == true &&
        group.reserve_ip == true &&
        group.access_activity_log == true
    end

    tests('Update Group').succeeds do
      group = compute.groups.get(@group_id)
      group.name = group.name + ' - RENAME'
      group.create_datacenter = false
      group.update
      group.wait_for {ready?}
      group.reload

      group.id == @group_id &&
        group.type == 'group' &&
        group.name == 'Fog Test - RENAME' &&
        group.create_datacenter == false
    end

    tests('Create Share').succeeds do
      share = compute.shares.create(:group_id => @group_id,
                                    :resource_id => @image_id,
                                    :edit_privilege => true,
                                    :share_privilege => true)
      @share_id = share.id

      share.type == 'resource' &&
        share.edit_privilege == true &&
        share.share_privilege == true
    end

    tests('List Shares').succeeds do
      shares = compute.shares.all(@group_id)

      shares.count > 0 &&
        shares[0].type = 'resource'
    end

    tests('Get Share').succeeds do
      share = compute.shares.get(@group_id, @image_id)

      share.id == @image_id &&
        share.type == 'resource' &&
        share.edit_privilege == true &&
        share.share_privilege == true
    end

    tests('Update Share').succeeds do
      share = compute.shares.get(@group_id, @image_id)
      share.edit_privilege = false
      share.update

      share.id == @image_id &&
        share.type == 'resource' &&
        share.edit_privilege == false
    end

    tests('Create User').succeeds do
      user = compute.users.create(:firstname => 'John',
                                  :lastname => 'Doe',
                                  :email => 'no-reply@example.com',
                                  :password => 'secretpassword123',
                                  :administrator => true,
                                  :force_sec_auth => false)
      user.wait_for {ready?}

      @user_id = user.id

      user.type == 'user' &&
        user.firstname == 'John' &&
        user.lastname == 'Doe' &&
        user.email == 'no-reply@example.com' &&
        user.administrator == true &&
        user.force_sec_auth == false
    end

    tests('List Users').succeeds do
      users = compute.users.all

      users.count > 0 &&
        users[0].type = 'user'
    end

    tests('Get User').succeeds do
      user = compute.users.get(@user_id)

      user.id == @user_id &&
        user.type == 'user' &&
        user.firstname == 'John' &&
        user.lastname == 'Doe' &&
        user.email == 'no-reply@example.com' &&
        user.administrator == true &&
        user.force_sec_auth == false &&
        user.sec_auth_active == false
    end

    tests('Update User').succeeds do
      user = compute.users.get(@user_id)
      user.administrator = false
      user.update

      user.id == @user_id &&
        user.type == 'user' &&
        user.administrator == false &&
        user.firstname == 'John' &&
        user.lastname == 'Doe' &&
        user.email == 'no-reply@example.com' &&
        user.force_sec_auth == false
    end

    tests('Add User to Group').succeeds do
      user = compute.users.add_group_user(@group_id, @user_id)

      user.id == @user_id &&
        user.type == 'user'
    end

    tests('Remove User from Group').succeeds do
      compute.users.remove_group_user(@group_id, @user_id)
    end
  end

  tests('user management failure') do
    tests('Create Group Failure (Missing Required Parameter)') do
      begin
        options = {
          create_datacenter: true
        }

        compute.create_group(options)
      rescue Exception => e
        returns(true, "exception contains 'Attribute 'name' is required'") {
          e.message.include? "Attribute 'name' is required"
        }
      end
    end

    tests('Get Group Failure (Nonexistent)') do
      begin
        compute.get_group('00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Get share Failure (Nonexistent)') do
      begin
        compute.get_share(@group_id, '00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Create User Failure (Missing Required Parameter)') do
      begin
        options = {
          firstname: 'John',
          lastname: 'Doe'
        }

        compute.create_user(options)
      rescue Exception => e
        returns(true, "exception contains 'Attribute 'email' is required'") {
          e.message.include? "Attribute 'email' is required"
        }
      end
    end

    tests('Get User Failure (Nonexistent)') do
      begin
        compute.get_user('00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end
  end

  tests('failure') do
    tests('Get Location Failure (Nonexistent)') do
      begin
        compute.get_location('00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Create Datacenter Failure (Missing Required Parameter)') do
      options = {
        name: 'Fog Datacenter'
      }

      begin
        compute.create_datacenter(options)
      rescue Exception => e
        returns(true, "exception contains 'Attribute 'location' is required'") {
          e.message.include? "Attribute 'location' is required"
        }
      end
    end

    tests('Get Datacenter Failure (Nonexistent)') do
      begin
        compute.get_datacenter('00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, "exception contains 'Resource does not exist'") {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Get LAN Failure (Nonexistent)') do
      begin
        compute.get_lan('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, "exception contains 'Resource does not exist'") {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Get Image Failure (Nonexistent)') do
      begin
        compute.get_image('00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, "exception contains 'Resource does not exist'") {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Create Volume Failure (Missing Required Parameter)') do
      options = {
        name: 'Fog Test'
      }

      begin
        compute.create_volume(@datacenter_id, options)
      rescue Exception => e
        returns(true, "exception contains 'Attribute 'size' is required'") {
          e.message.include? "Attribute 'size' is required"
        }
      end
    end

    tests('Create Server Failure (Missing Required Parameter)') do
      options = {
        name: 'Fog Test',
        ram: 1024
      }

      begin
        compute.create_server(@datacenter_id, options)
      rescue Exception => e
        returns(true, "exception contains 'Attribute 'cores' is required'") {
          e.message.include? "Attribute 'cores' is required"
        }
      end
    end

    tests('Get Server Failure (Nonexistent)') do
      begin
        compute.get_server('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, "exception contains 'Resource does not exist'") {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Get Volume Failure (Nonexistent)') do
      begin
        compute.get_volume('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, "exception contains 'Resource does not exist'") {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Get Snapshot Failure (Nonexistent)') do
      begin
        compute.get_snapshot('00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, "exception contains 'Resource does not exist'") {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Get Request Failure (Nonexistent)') do
      begin
        compute.get_request('00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, "exception contains 'Resource does not exist'") {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Get IP Block Failure (Nonexistent)') do
      begin
        compute.get_ip_block('00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Create NIC Failure (Missing Required Parameter)') do
      begin
        compute.nics.create(:datacenter_id => @datacenter_id,
                            :server_id => @server_id,
                            :name => 'Fog Test')
      rescue Exception => e
        returns(true, "exception contains 'lan is required for this operation'") {
          e.message.include? "lan is required for this operation"
        }
      end
    end

    tests('Get NIC Failure (Nonexistent)') do
      begin
        compute.get_nic('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Create Firewall Rule Failure (Missing Required Parameter)') do
      begin
        compute.firewall_rules.create(:datacenter_id => @datacenter_id,
                                      :server_id => @server_id,
                                      :nic_id => @nic_id,
                                      :name => 'Fog Test')
      rescue Exception => e
        returns(true, "exception contains 'protocol is required for this operation'") {
          e.message.include? "protocol is required for this operation"
        }
      end
    end

    tests('Get Firewall Rule Failure (Nonexistent)') do
      begin
        compute.get_firewall_rule('00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000',
                                  '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('Create Load Balancer Failure (Missing Required Parameter)') do
      begin
        compute.create_load_balancer(@datacenter_id)
      rescue Exception => e
        returns(true, "exception contains 'Attribute 'name' is required'") {
          e.message.include? "Attribute 'name' is required"
        }
      end
    end

    tests('Get Load Balancer Failure (Nonexistent)') do
      begin
        compute.get_load_balancer(@datacenter_id, '00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('List Resources Failure (Nonexistent)') do
      begin
        compute.resources.get_by_type('unknown')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end

    tests('List Resources Type Failure (Nonexistent)') do
      begin
        compute.resources.get_resource_by_type('datacenter', '00000000-0000-0000-0000-000000000000')
      rescue Exception => e
        returns(true, 'exception contains \'Resource does not exist\'') {
          e.message.include? 'Resource does not exist'
        }
      end
    end
  end

  tests('user management cleanup') do
    Excon.defaults[:connection_timeout] = 500

    tests('Remove User').succeeds do
      user = compute.users.get(@user_id)

      user.delete
    end

    tests('Remove Share').succeeds do
      share = compute.shares.get(@group_id, @image_id)

      share.delete
    end

    tests('Remove Group').succeeds do
      group = compute.groups.get(@group_id)

      group.delete
    end
  end

  tests('cleanup') do
    Excon.defaults[:connection_timeout] = 500

    tests('Remove Balanced NIC').succeeds do
      load_balancer = compute.load_balancers.get(@datacenter_id, @load_balancer_id)
      result = load_balancer.remove_nic_association(@nic_id)

      sleep(60) if ENV["FOG_MOCK"] != "true"

      result
    end

    tests('Remove Load Balancer').succeeds do
      load_balancer = compute.load_balancers.get(@datacenter_id, @load_balancer_id)

      load_balancer.delete
    end

    tests('Remove Firewall Rule').succeeds do
      firewall_rule = compute.firewall_rules.get(@datacenter_id, @composite_server_id, @nic_id, @firewall_rule_id)

      firewall_rule.delete
    end

    tests('Release IP Block').succeeds do
      ip_block = compute.ip_blocks.get(@ip_block_id)

      ip_block.delete
    end

    tests('Remove NIC').succeeds do
      sleep(60) if ENV["FOG_MOCK"] != "true"
      nic = compute.nics.get(@datacenter_id, @composite_server_id, @nic_id)

      nic.delete
    end

    tests('Remove LAN').succeeds do
      sleep(60) if ENV["FOG_MOCK"] != "true"
      lan = compute.lans.get(@datacenter_id, @lan_id)

      lan.delete
    end

    tests('Remove Snapshot').succeeds do
      snapshot = compute.snapshots.get(@snapshot_id)

      snapshot.delete
    end

    tests('Remove Volume').succeeds do
      volume = compute.volumes.get(@datacenter_id, @volume_id)

      volume.delete
    end

    tests('Remove Server').succeeds do
      server = compute.servers.get(@datacenter_id, @server_id)
      composite_server = compute.servers.get(@datacenter_id, @composite_server_id)

      server.delete and composite_server.delete
    end

    tests('Remove Datacenter').succeeds do
      datacenter = compute.datacenters.get(@datacenter_id)
      composite_dc = compute.datacenters.get(@composite_dc_id)

      datacenter.delete and composite_dc.delete
    end
  end
end
