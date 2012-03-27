#!/usr/bin/ruby
# Copyright 2012 Smartling, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'tests/test_helper.rb'

module SmartlingTests
  class SmartlingFileApiTest < Test::Unit::TestCase

    TEST_FILE_YAML = 'tests/upload.yaml'

    def setup
      @config = SmartlingTests.server_config
      @log = SmartlingTests.logger
    end

    def yaml_file
      data = <<-EOL
hello: world
we have: cookies
      EOL
      f = Tempfile.new('smartling_tests')
      f.write(data)
      f.flush
      f.pos = 0
      return f
    end

    def test_1_list
      @log.debug '<- FileAPI:list'
      sl = Smartling::File.new(@config)
      res = nil
      assert_nothing_raised do res = sl.list end
      @log.debug res.inspect
    end

    def test_2_upload
      @log.debug '<- FileAPI:upload'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.upload(yaml_file, TEST_FILE_YAML, 'YAML')
      end
      @log.debug res.inspect
    end

    def test_3_status
      @log.debug '<- FileAPI:status'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.status(TEST_FILE_YAML, :locale => 'en-US')
      end
      @log.debug res.inspect
    end

    def test_4_download_en
      @log.debug '<- FileAPI:download EN'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.download(TEST_FILE_YAML, :locale => 'en-US')
      end
      @log.debug res.inspect
    end

    def test_5_download_ru
      @log.debug '<- FileAPI:download RU'
      sl = Smartling::File.new(@config)
      
      res = nil
      assert_nothing_raised do
        res = sl.download(TEST_FILE_YAML, :locale => 'ru-RU')
      end
      @log.debug res.inspect
    end

  end
end

