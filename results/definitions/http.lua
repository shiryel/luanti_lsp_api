---@meta
---`HTTPRequest` definition
---------------------------

-- Used by `HTTPApiTable.fetch` and `HTTPApiTable.fetch_async`.
-- Timeout for request to be completed in seconds. Default depends on engine settings.
-- The http method to use. Defaults to "GET".
-- Data for the POST, PUT or DELETE request.
-- Accepts both a string and a table. If a table is specified, encodes
-- table as x-www-form-urlencoded key-value pairs.
-- Optional, if specified replaces the default minetest user agent with
-- given string.
-- Optional, if specified adds additional headers to the HTTP request.
-- You must make sure that the header strings follow HTTP specification
-- ("Key: Value").
--
-- Example: `{ "Accept-Language: en-us", "Accept-Charset: utf-8" }`.
-- * Optional, if true performs a multipart HTTP request.
-- * Default is false.
-- * Post only, data must be array.
-- Deprecated, use `data` instead. Forces `method = "POST"`.
---@class mt.HTTPReqDef
---@field url string
---@field timeout number
---@field method "GET"|"POST"|"PUT"|"DELETE"
---@field data string|table
---@field user_agent string|nil
---@field extra_headers table|nil
---@field multipart boolean|nil
---@field post_data string|table