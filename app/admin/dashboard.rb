ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  users = About.all
  static_data = []
  static_data << {text: "First", checked: true}
  static_data << {text: "Second", checked: true}
  static_data << {text: "Third", checked: false}
  static_data << {text: "Fourth", checked: true}
  static_data << {text: "Fifth", checked: false}

  page_action :lock, method: :post do
    if params[:key] == "js"
      returnValue = ["Account Classes", "Ach Transmittals"]
      render json: returnValue
    else
      # @returnValue = static_data
      object_fields = About.column_names
      ReturnObject = Struct.new(:id, :value, :hidden_fields)
      @returnValue = ReturnObject.new('', object_fields, ["sd", "dsdf", "dss"])
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { }
      end
    end
  end

  page_action :updateAbout, method: :post do
    @about = About.find_by(id: params[:about_id])
    if @about.update_attributes(option: params[:option], settings: params[:settings])
      render json: 'true'
    else
      render json: 'false'
    end
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do
    key = params[:title].present? ? params[:title] : "about"
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end

      div class: "table_tools" do
        ul class: "table_tools_segmented_control" do
          titles = ["about", "test"]
          
          titles.each do |title|
            li class: "#{'selected' if key == title}" do
              a class: "table_tools_button title", href: "/admin/dashboard?title=#{title}" do
                title.humanize
              end
            end
          end
        end
      end
    end

    columns do
      column do
        panel key do
          render key, {key: key, data: static_data, users: users}
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
