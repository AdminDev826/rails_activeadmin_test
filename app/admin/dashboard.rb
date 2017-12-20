ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }
  items = {
    a: %w(a b c d e f g),
    b:%w(a b c d e f g) 
  }

  page_action :lock, method: :post do
    p items["a".to_sym]
    @about = []
    @about << {text: "First", checked: true}
    @about << {text: "Second", checked: true}
    @about << {text: "Third", checked: false}
    @about << {text: "Fourth", checked: true}
    @about << {text: "Fifth", checked: false}
    respond_to do |format|
      # if the response fomat is html, redirect as usual
      format.html { redirect_to root_path }
  
      # if the response format is javascript, do something else...
      format.js { }
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
          render key, key: key
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
