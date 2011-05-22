# == Schema Information
# Schema version: 20110522210205
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  username           :string(255)
#  email              :string(255)
#  encrypted_password :string(255)
#  first_name         :string(255)
#  last_name          :string(255)
#  extra              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :country, :first_name, :last_name, :extra
end
