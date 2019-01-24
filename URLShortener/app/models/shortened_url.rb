# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
	validates :long_url, presence: true, uniqueness: true
	validates :short_url, presence: true, uniqueness: true
	validates :user_id, presence: true, uniqueness: true

	attr_reader :id, :long_url, :user_id
	attr_accessor :short_url
	def self.random_code
		code = SecureRandom.urlsafe_base64
		return code
	end

	def self.create!
		random_code = ShortenedUrl.random_code
		while ShortenedUrl.exists?(:short_url => random_code)
			random_code = ShortenedUrl.random_code
		end

		ShortenedUrl.new({:id => @id, :long_url => @long_url, :short_url => random_code, :user_id => @user_id})
	end
	
	belongs_to(:submitter, {
		primary_key: :id,
		foreign_key: :user_id,
		class_name: 'User'
	})
	
end
