defmodule TaskTrackerWeb.SessionController do
    use TaskTrackerWeb, :controller

    def create(conn, %{"name" => name}) do
        user = TaskTracker.Users.get_user_by_name(name)
        if user do
            conn
            |> put_session(:user_id, user.id)
            |> put_flash(:info, "Hello #{user.name}")
            |> redirect(to: Routes.page_path(conn, :index))
        else
            conn
            |> put_flash(:error, "No user found")
            |> redirect(to: Routes.page_path(conn, :index))
        end
    end

    def delete(conn, _params) do
        conn
        |> delete_session(:user_id)
        |> put_flash(:info, "Signed out.")
        |> redirect(to: Routes.page_path(conn, :index))
    end
end