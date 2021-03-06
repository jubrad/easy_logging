require 'logger'

require_relative "easy_logging/version"

module EasyLogging

  @loggers = {}

  def logger
    @logger ||= EasyLogging.logger_for(self.class.name)
  end

  # Executed when the module is included. See: https://stackoverflow.com/a/5160822/2771889
  def self.included(base)
    # Class level logger method for includer class (base)
    def base.logger
      @logger ||= EasyLogging.logger_for(self)
    end
  end

  # Global, memoized, lazy initialized instance of a logger
  def self.logger_for(classname)
    @loggers[classname] ||= configure_logger_for(classname)
  end

  def self.configure_logger_for(classname)
    logger = Logger.new(STDOUT)
    logger.progname = classname
    logger
  end

end
