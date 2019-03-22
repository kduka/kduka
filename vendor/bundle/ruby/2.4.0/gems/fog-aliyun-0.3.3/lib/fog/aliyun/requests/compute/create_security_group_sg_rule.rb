# frozen_string_literal: true

module Fog
  module Compute
    class Aliyun
      class Real
        # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.3.1.DGkmH7#/pub/ecs/open-api/securitygroup&authorizesecuritygroup]
        def create_security_group_sg_rule(securitygroup_id, source_securitygroup_id, option = {})
          action = 'AuthorizeSecurityGroup'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutParameters(action, sigNonce, time)
          pathUrl = defaultAliyunUri(action, sigNonce, time)

          parameters['SecurityGroupId'] = securitygroup_id
          pathUrl += '&SecurityGroupId='
          pathUrl += securitygroup_id

          parameters['SourceGroupId'] = source_securitygroup_id
          pathUrl += '&SourceGroupId='
          pathUrl += source_securitygroup_id

          nicType = 'intranet'
          parameters['NicType'] = nicType
          pathUrl += '&NicType='
          pathUrl += nicType

          portRange = option[:portRange]
          portRange ||= '-1/-1'
          parameters['PortRange'] = portRange
          pathUrl += '&PortRange='
          pathUrl += URI.encode(portRange, '/[^!*\'()\;?:@#&%=+$,{}[]<>`" ')

          protocol = option[:protocol]
          protocol ||= 'all'
          parameters['IpProtocol'] = protocol
          pathUrl += '&IpProtocol='
          pathUrl += protocol

          sourceGOAccount = option[:sourceGroupOwnerAccount]
          if sourceGOAccount
            parameters['SourceGroupOwnerAccount'] = sourceGOAccount
            pathUrl += '&SourceGroupOwnerAccount='
            pathUrl += sourceGOAccount
          end

          policy = option[:policy]
          policy ||= 'accept'
          parameters['Policy'] = policy
          pathUrl += '&Policy='
          pathUrl += policy

          priority = option[:priority]
          priority ||= '1'
          parameters['Priority'] = priority
          pathUrl += '&Priority='
          pathUrl += priority

          signature = sign(@aliyun_accesskey_secret, parameters)
          pathUrl += '&Signature='
          pathUrl += signature

          request(
            expects: [200, 203],
            method: 'GET',
            path: pathUrl
          )
        end
      end
    end
  end
end
