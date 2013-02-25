require 'open-uri'
require 'rubygems'
require 'minitest/autorun'
require 'json'


# run test-app before!
# returns as hash:
#  ["REQUEST_PATH", "REQUEST_URI", "REQUEST_METHOD", "REQUEST_PATH", "PATH_INFO"]

class AppStarter
  def self.start_app
    @test_app ||= begin
      app_pid = IO.popen("rackup 2>&1 >> /dev/null")
      sleep 0.5
      app_pid
    end
  end

  def self.kill_app
    `sudo pkill -9 -f rackup`
  end
end

#MiniTest::Unit.after_tests() { AppStarter.kill_app }

#LANGUAGES = %w(de en fr pl nl es it)
describe "testing" do
  before do
    #AppStarter.start_app
  end

  def json_request(url)
    r = `curl -s '#{url}'`
    JSON.parse(r) rescue r
  end

  def plain_request(url)
    r = `curl -s '#{url}'`
  end

  def headers_request(url)
    r = `curl -s --head #{url}`
  end

  def check_request_uri(url)
    r = json_request(url)
    remove_port(r["REQUEST_URI"].gsub("http://", ''))
  end

  def remove_port(url)
    url.gsub(/\:9292/, '')
  end


  describe 'LUA' do
    describe 'hellolua' do
      it "works for Anonymous" do
        plain_request("0.0.0.0/hellolua").must_equal "Hello from LUA, Anonymous!\n"
      end

      it "works for named person" do
        plain_request("0.0.0.0/hellolua?name=TestUser").must_equal "Hello from LUA, TestUser!\n"
      end
    end
  end
end
