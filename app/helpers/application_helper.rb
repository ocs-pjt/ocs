module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-danger alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  # Display link to download a file
  def display_filename(file)
    link_to File.basename(file.path), file.url 
  end

  # Display an export button
  def export_button(options)
    button_to 'Export CSV',
      search_export_path(format: options[:format],
      resource_type: options[:resource_type]),
      multipart: true,
      class: 'btn btn-success pull-right'
  end

  # Display popup template in case the text is too long
  def truncate_popup(resource, size = 50)
    if resource.data.size > size
      render partial: 'shared/truncate_popup', locals: {id: resource.id, data: resource.data, size: size}
    else
      resource.data
    end
  end
end
