#!/bin/bash

# This script removes the resource group and all underlying resources
# Note: This is permanent , there is no un-delete :)

az group delete -g php-poc --no-wait