module SitesHelper
    def title(name,show_title = true)
        @show_title = show_title
        content_for(:title) do
            name
        end
    end
    def nav_link(text,path)
        if current_page?(path)
            content_tag :li, class: "nav-item" do
                link_to(text, path, class: "nav-link active my-nav-link", aria: {current: 'page'})
            end
        else
            content_tag :li, class: "nav-item" do
                link_to(text, path, class: "nav-link my-nav-link")
            end
        end
    end
end
