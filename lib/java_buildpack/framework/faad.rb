# Encoding: utf-8
# Cloud Foundry Java Buildpack
# Copyright 2013-2016 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'fileutils'
require 'java_buildpack/component/versioned_dependency_component'
require 'java_buildpack/framework'

module JavaBuildpack
  module Framework

    # Encapsulates the functionality for enabling Faad.
    class Faad < JavaBuildpack::Component::VersionedDependencyComponent

      # (see JavaBuildpack::Component::BaseComponent#compile)
      def compile
	#FileUtils.mkdir_p("#{@droplet.sandbox}")
        download(@version, @uri) { |file| expand file }
        #@droplet.copy_resources
      end

      # (see JavaBuildpack::Component::BaseComponent#release)
      def release
        
      end

      protected

      # (see JavaBuildpack::Component::VersionedDependencyComponent#supports?)
      def supports?
	true
      end

      private

      def expand(file)
        with_timing "Expanding Faad to #{@droplet.root}" do
          Dir.mktmpdir do |root|
            root_path = Pathname.new(root)
	    shell "tar xzf #{file.path} -C #{@droplet.root}"
            #unpack_agent root_path
          end
        end
      end

      #def unpack_agent(root)
      #  FileUtils.mkdir_p("faad")
      #  FileUtils.mv(root + 'faad', agent_dir)
      #  FileUtils.mv(root + 'agent' + agent_unpack_path + lib_name, agent_dir)
      #end

    end

  end
end



