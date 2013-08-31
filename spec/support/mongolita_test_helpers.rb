# encoding: utf-8

module MongolitaTestHelpers
  @@shell_strip = /MongoDB shell version:.*?connecting to: test/m

  def eval_mongo exec_script
    cmd = %Q{
      #{$mongod.db_path}/mongo --eval "
      load('#{lib_path}');
      #{helper.ensure_test_db_context};
      #{exec_script};"
    }
    @response = %x/#{cmd}/
    strip_noise
  end

  private

  def strip_noise
    @response[@@shell_strip] = '' if @response.match @@shell_strip
    @response.strip
  end

  def helper
    @helper ||= begin
      mdl = Module.new
      mdl.module_eval do
        def ensure_test_db_context
          %Q{
            (function() {
              if (db != 'test') {
                print('the db variable is not set to the test database context');
                return 0;
              }
            })();
          }
        end
      end
      Object.new.tap { |o| o.extend mdl }
    end
  end

end
