#!/bin/bash

#
# Create record (CRUD)
# @param {string} table
# @param {string:json} params
# @returns {string:json}
#
function api_create() {
  curl                                         \
    --request POST                             \
    --header 'Content-Type: application/json'  \
    --data "$2"                                \
    "/create/$1"
}

#
# Read record(s) (CRUD)
# @param {string} table
# @param {string:json} params
# @returns {string:json}
#
function api_read() {
  curl                                         \
    --request POST                             \
    --header 'Content-Type: application/json'  \
    --data "$2"                                \
    "/read/$1"
}

#
# Update record (CRUD)
# @param {string} table
# @param {string:json} params
# @returns {string:json}
#
function api_update() {
  curl                                         \
    --request POST                             \
    --header 'Content-Type: application/json'  \
    --data "$2"                                \
    "/update/$1"
}

#
# Delete record (CRUD)
# @param {string} table
# @param {string:json} params
# @returns {string:json}
#
function api_delete() {
  curl                                         \
    --request POST                             \
    --header 'Content-Type: application/json'  \
    --data "$2"                                \
    "/delete/$1"
}
