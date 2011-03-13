#--
# Copyleft shura. [ shura1991@gmail.com ]
#
# This file is part of arbi.
#
# arbi is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# arbi is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with arbi. If not, see <http://www.gnu.org/licenses/>.
#++

require 'optparse'
require 'arbi/server'
require 'arbi/version'

module Arbi

module Cli

class Server
  def initialize
    @address = Arbi::Config[:server][:address]
    @port = Arbi::Config[:server][:port]

    self.parse_args

    Arbi::Server.start(@address, @port)
  end

protected
  def parse_args
    OptionParser.new do |o|
      o.program_name  = 'arbid'
      o.banner        = "Arbi server v#{Arbi::VERSION}, USAGE:"

      o.on('-C', '--config CONF', 'Select configurations path, default to /etc/arbi.conf') do |conf|
        Arbi::Config.parse(conf)
      end

      o.on('-a', '--bind-address ADDR', 'Address to bind, default to "127.0.0.1"') do |addr|
        @address = addr
      end

      o.on('-p', '--port PORT', 'Port to use for server, default to 6969') do |port|
        @port = port
      end

      o.on('-V', '--version', 'Print version and exit') do
        puts "Arbi server v#{Arbi::VERSION}"
        exit 0
      end

      o.on_tail('-h', '--help', 'Print this help and exit') do
        puts o.to_s
        exit 0
      end
    end.parse!
  rescue OptionParser::MissingArgument
    puts "At least one argument is required for this option."
    puts "See help for detail"
    exit 1
  end
end

end

end
