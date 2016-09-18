# frozen_string_literal: true

# Copyright 2016 New Context Services, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'kitchen'
require 'terraform/client'
require 'terraform/configurable'

module Kitchen
  module Driver
    # Terraform state lifecycle activities manager
    class Terraform < Base
      include ::Terraform::Client

      include ::Terraform::Configurable

      kitchen_driver_api_version 2

      no_parallel_for

      def create(_state = nil)
        validate_installed_version
      end

      def destroy(_state = nil)
        validate_configuration_files
        download_modules
        plan_execution destroy: true
        apply_execution_plan
      end
    end
  end
end
