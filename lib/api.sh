#!/bin/bash

#
# Create record (CRUD)
# @param {string} table
# @param {string:json} params
# @returns {string:json}
#
function api_create() {
  curl --insecure --request POST               \
    --header 'Content-Type: application/json'  \
    --data "$2" "http://$HOST:$PORT/create/$1"
}

#
# Read record(s) (CRUD)
# @param {string} table
# @param {string:json} params
# @returns {string:json}
#
function api_read() {
  curl --insecure --request POST               \
    --header 'Content-Type: application/json'  \
    --data "$2" "http://$HOST:$PORT/read/$1"
}

#
# Update record (CRUD)
# @param {string} table
# @param {string:json} params
# @returns {string:json}
#
function api_update() {
  curl --insecure --request POST               \
    --header 'Content-Type: application/json'  \
    --data "$2" "http://$HOST:$PORT/update/$1"
}

#
# Delete record (CRUD)
# @param {string} table
# @param {string:json} params
# @returns {string:json}
#
function api_delete() {
  curl --insecure --request POST               \
    --header 'Content-Type: application/json'  \
    --data "$2" "http://$HOST:$PORT/delete/$1"
}
