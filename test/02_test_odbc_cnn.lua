require "config"
local lunit = require "lunitx"

local TEST_NAME = 'Connection test'
if _VERSION >= 'Lua 5.2' then  _ENV = lunit.module(TEST_NAME,'seeall')
else module( TEST_NAME, package.seeall, lunit.testcase ) end

local env, cnn

function teardown()
  if cnn then cnn:destroy() end
  if env then env:destroy() end
  cnn = nil
  env = nil
end

function setup()
  env, cnn = do_connect()
  assert_not_nil(env, cnn)
end

function test_basic()
  assert_equal(env, cnn:environment())
end

function test_destroy()
  assert_not_nil(env)
  assert_not_nil(cnn)
  assert_false(cnn:destroyed())
  assert_pass(function() cnn:drvname() end)
  assert_true(cnn:destroy())
  assert_true(cnn:destroyed())
  assert_error(function() cnn:drvname() end)
  assert_true(cnn:destroy())
end

function test_driverconnect()
  assert_true(cnn:connected())
  assert_true(cnn:disconnect())
  assert_true(not cnn:connected())
  assert_false(cnn:destroyed())
  local str = assert_string(cnn:driverconnect(CNN_DRV))
  assert_true(cnn:connected())
  assert_true(cnn:disconnect())
  assert_string(cnn:driverconnect(str))
end

function test_connect()
  assert_true(cnn:connected())
  assert_true(cnn:disconnect())
  assert_true(not cnn:connected())
  assert_false(cnn:destroyed())
  assert_equal(cnn, cnn:connect(unpack(CNN_DSN)))
  assert_true(cnn:disconnect())
  assert_true(not cnn:connected())
end

