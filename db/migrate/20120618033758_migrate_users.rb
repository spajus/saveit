class MigrateUsers < ActiveRecord::Migration
  def change
    if User.attr_accessible(:provider)
      for user in User.all()
        if user.provider
          puts "Migrating user: #{user.name}, #{user.provider}:#{user.uid}"
          user.user_tokens.build(provider: user.provider, uid: user.uid)
          if user.email.blank?
            user.email = "#{user.uid}@#{user.provider}.com"
          end
          user.confirmed_at = Date.current()
          user.save!
        end
      end
    end
  end
end
