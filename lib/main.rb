require "bugzilla"

module Bugzilla
  class EditableUser < User
    protected
    def _create(cmd, email, full_name = "", password = "")
      params = {}
      params[:email] = email
      if !full_name.empty?
        params[:full_name] = full_name
      end
      if !password.empty?
        params[:password] = password
      end
      #Temporary insert cmd as User.create
      @iface.call("User.create", params)
    end
  end
end


xmlrpc = Bugzilla::XMLRPC.new("192.168.5.41", 8880)

#get bugzilla version
puts "Version of bugzilla: " + Bugzilla::Bugzilla.new(xmlrpc).version["version"]

user = Bugzilla::User.new(xmlrpc)
user.session("dajer@tut.by", "saroot") do
  puts Bugzilla::EditableUser.new(xmlrpc).create("sergey.gaychuk1@gmail.com", "Gaychuk", "12345678")
end

puts "End of test"
