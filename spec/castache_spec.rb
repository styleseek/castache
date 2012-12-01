# encoding: utf-8

require 'spec_helper'

describe Castache do

  let(:obj) { OpenStruct.new :string => 'Test',
                             :integer => 42,
                             :float => 1.0,
                             :array => [:a,:b,:c],
                             :hash => {'key'=>'value'},
                             :date => DateTime.strptime('253555860','%s') }
  before do
    Castache.redis = Redis.current
  end

  after do
    Castache.redis.flushall
  end

  describe "#redis" do
    it "returns the current redis connection" do
      Castache.redis.must_be_kind_of Redis
    end
  end

  describe "#redis=" do
    describe "can connect to redis" do
      it "when given a Redis object" do
        (Castache.redis = Redis.new)
        Castache.redis.must_be_kind_of Redis
      end

      it "when given a uri string" do
        Castache.redis = "redis:://localhost:6379"
        Castache.redis.must_be_kind_of Redis
      end

      it "when given a hash" do
        Castache.redis = { host: 'localhost', port: 6379, thread_safe: true }
        Castache.redis.must_be_kind_of Redis
      end
    end
  end

  describe "#set" do
    it "can write an object to the cache" do
      Castache.set('write-test',obj).must_equal obj
    end
  end

  describe "#get" do
    it "can read an object from the cache" do
      Castache.set('read-test',obj)
      Castache.get('read-test').must_equal obj
    end

    it "returns nil if the key fails to retrieve an object" do
      Castache.get('read-nil-test').must_be_nil
    end
  end

  describe "#mget" do
    before do
      Castache.set('get_all-test0', obj)
      Castache.set('get_all-test1', [:a])
      Castache.set('get_all-test2', [:b])
      Castache.set('get_all-test3', [:c])
    end

    it "can get multiple objects from the cache" do
      keys = ['get_all-test0','get_all-test1','get_all-test2','get_all-test3']
      Castache.mget(keys).must_equal [obj, [:a], [:b], [:c]]
    end
  end

  describe "#fetch" do
    before do
      @hash = {:test => 'data'}
      Castache.set('fetch-test', @hash)
    end

    it "returns an object in the cache, if it already exits" do
      result = Castache.fetch('fetch-test') { obj }
      result.must_equal @hash
    end

    it "stores the block contents in the cache, if it does not exist" do
      Castache.fetch('fetch-nil-test') { obj }.must_equal obj
    end
  end

end
