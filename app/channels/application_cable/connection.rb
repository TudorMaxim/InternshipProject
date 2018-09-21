module ApplicationCable
  class Connection < ActionCable::Connection::Base
<<<<<<< HEAD
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      if (current_user = env['warden'].user)
        current_user
      else
        reject_unauthorized_connection
      end
    end
=======
>>>>>>> 507e1839bd0bd2bd5110eb622a62489feade8e2f
  end
end
