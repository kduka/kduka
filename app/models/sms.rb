class Sms < Logger
  def self.info(message=nil)
    @sms_log ||= Logger.new("#{Rails.root}/log/sms.log")
    @sms_log.info(message) unless message.nil?
  end
end
