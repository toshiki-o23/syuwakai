=begin
Copyright 2013-2017 Michal Papis <mpapis@gmail.com>

This file is part of pluginator.

pluginator is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

pluginator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with pluginator.  If not, see <http://www.gnu.org/licenses/>.
=end

module Pluginator

  # base error for all Pluginator errors
  class PluginatorError < RuntimeError
  private

    def list_to_s(list)
      list.map { |plugin| plugin.to_s.inspect }.join(", ")
    end
  end

  # raised when plugin can not be found, generated by `*!` methods
  class MissingPlugin < PluginatorError
    # initialize new error
    # @param type [String] type of the loaded plugin
    # @param name [String] name of the loaded plugin
    # @param list [Array]  list of available plugins
    def initialize(type, name, list)
      super("Can not find plugin #{name.inspect} in #{list_to_s(list)} for type #{type.inspect}.")
    end
  end

  # raised when type can not be found, generated by `*!` methods
  class MissingType < PluginatorError
    # initialize new error
    # @param type [String] type of the loaded plugin
    # @param list [Array]  list of available types
    def initialize(type, list)
      super("Can not find type #{type.inspect} in #{list_to_s(list)}.")
    end
  end
end