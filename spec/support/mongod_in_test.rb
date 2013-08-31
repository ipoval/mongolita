# encoding: utf-8$

class MongodInTest < Hash
  def run
    FileUtils.mkdir_p $mongod[:dbpath]
    pid = Process.spawn "#{$mongod.db_path}/mongod --dbpath #{$mongod[:dbpath]} --logpath /dev/null --fork"
    Process.waitpid pid
    wait_for_mongodb_start
  end

  def db_path; fetch :bin; end

  private

  def wait_for_mongodb_start; sleep 2; end
end
