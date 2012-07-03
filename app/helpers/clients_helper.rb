module ClientsHelper
  def sort_clients_path(field, other_params = {})
    clients_path ({:sort => field}.merge(other_params))
  end
end
