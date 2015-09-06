class Permission
  extend Forwardable

  attr_reader :user, :store, :controller, :action

  def initialize(user, store = nil)
    @user  = user || User.new
    @store = store || Store.new
  end

  def_delegators :user, :platform_admin?,
                 :store_admin?,
                 :registered_user?

  def allow?(controller, action)
    @controller = controller
    @action = action

    case
      # when platform_admin?
      #   platform_admin_permissions
      when store_admin? && store.id == user.store_id
        store_admin_permissions
      # when store_admin?
      #   store_admin_permissions
      when registered_user?
        registered_user_permissions
      else
        guest_permissions
    end
  end

  private

  # def platform_admin_permissions
  #   return true if (controller == 'site') && (action == 'index')
  #   return true if (controller == 'sessions') &&
  #       (action.in? %w( new create destroy ))
  #   return true if (controller == 'users') &&
  #       (action.in? %w( show edit update destroy ))
  #   return true if (controller == 'stores') &&
  #       (action.in? %w( index show new create edit update))
  #   return true if (controller == 'photos') &&
  #       (action.in? %w( index show new create edit update destroy ))
  #   return true if (controller == 'photos/categories') &&
  #       (action == 'show')
  #   return true if (controller == 'orders') &&
  #       (action.in? %w( index show ))
  #   return true if (controller == 'admin/orders') &&
  #       (action.in? %w( index show update ))
  #   return true if (controller == 'stores/photos') &&
  #       (action.in? %w( index show new create edit update))
  #   return true if (controller == 'stores/categories') &&
  #       (action == 'show')
  # end

  def store_admin_permissions
    return true if (controller == 'site') && (action == 'index')
    return true if (controller == 'sessions') &&
        (action.in? %w( new create destroy ))
    return true if (controller == 'users') &&
        (action.in? %w( show edit update ))
    return true if (controller == 'stores') &&
        (action.in? %w( index edit update ))
    return true if (controller == 'photos') &&
        (action.in? %w( index show new create edit update destroy ))
    return true if (controller == 'photos/categories') &&
        (action == 'show')
    return true if (controller == 'orders') &&
        (action.in? %w( index show ))
    return true if (controller == 'admin/orders') &&
        (action.in? %w( index show update ))
    return true if (controller == 'stores/photos') &&
        (action.in? %w( index show new create edit update))
    return true if (controller == 'stores/categories') &&
        (action == 'show')
    return true if (controller == 'cart_photos') &&
        (action.in? %w( index create update destroy ))
  end

  def registered_user_permissions
    return true if (controller == 'site') && (action == 'index')
    return true if (controller == 'sessions') &&
        (action.in? %w( new create destroy ))
    return true if (controller == 'users') &&
        (action.in? %w( show edit update ))
    return true if (controller == 'stores') &&
        (action.in? %w( index new create ))
    return true if (controller == 'photos') &&
        (action.in? %w( index show ))
    return true if (controller == 'photos/categories') &&
        (action == 'show')
    return true if (controller == 'cart_photos') &&
        (action.in? %w( index create update destroy ))
    return true if (controller == 'orders') &&
        (action.in? %w( index show create ))
    return true if (controller == 'stores/photos') &&
        (action.in? %w( index show ))
    return true if (controller == 'stores/categories') &&
        (action == 'show')
  end

  def guest_permissions
    return true if (controller == 'site') && (action == 'index')
    return true if (controller == 'sessions') &&
        (action.in? %w( new create ))
    return true if (controller == 'users') &&
        (action.in? %w( new create ))
    return true if (controller == 'stores') &&
        (action.in? %w( index show ))
    return true if (controller == 'stores/photos') &&
        (action.in? %w( index show ))
    return true if (controller == 'photos') &&
        (action.in? %w( index show ))
    return true if (controller == 'photos/categories') &&
        (action == 'show')
    return true if (controller == 'cart_photos') &&
        (action.in? %w( index create update destroy ))
    return true if (controller == 'orders') &&
        (action == 'create')
    return true if (controller == 'stores/categories') &&
        (action == 'show')
  end
end
