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

  # -i option, to include headers
  def full_request(url)
    r = `curl -s -i '#{url}'`
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

    describe 'lua-content' do
      it "works" do
        plain_request("0.0.0.0/lua-content").must_equal "Hello, Sub-Request is working properly!\n\n"
      end
    end

    describe 'recur' do
      it "works without params" do
        plain_request("0.0.0.0/recur").must_equal "num is: 0\nend\n"
      end

      it "works without params" do
        plain_request("0.0.0.0/recur?num=3").must_equal %Q{num is: 3
status=200 body=num is: 2
status=200 body=num is: 1
status=200 body=num is: 0
end
}
      end

      it "bails out, if num > 50" do
        plain_request("0.0.0.0/recur?num=51").must_equal "num too big\n"
      end
    end

    describe "ctx" do
      it "works" do
        plain_request("0.0.0.0/ctx").must_equal "12345\n"
      end
    end


    # not WORKING!
    describe "shared-ctx" do
      it "works" do
        skip
        plain_request("0.0.0.0/shared-ctx").must_equal "nil\n"
      end
    end
  end

  describe "memcache" do
    it "works" do
      plain_request("0.0.0.0/memcached").must_equal "STORED\n"
      #plain_request("0.0.0.0/mem").must_equal "/mem\n"
      #plain_request("0.0.0.0/mem/hey").must_equal "/mem/hey\n"
    end
  end


  describe "redis" do

  end


  describe "varnish" do

  end


  describe "ssi" do
    describe 'home' do
      it "works with esi inclusion" do
        plain_request("0.0.0.0/home").must_equal "home_index\n\nESI CONTENT"
      end
    end
  end
end
