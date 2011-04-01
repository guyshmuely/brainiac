# Change FieldWithError behavior
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  error_class = "error"
  if html_tag !~ /type="hidden"/
    if html_tag =~ /<(input|textarea|select)[^>]+class=/
      class_attribute = html_tag =~ /class=['"]/
      style_attribute = html_tag =~ /style=['"]/
      style_attribute+=7 unless style_attribute.nil?
      html_tag.insert(class_attribute+7, "#{error_class} ")
    elsif html_tag =~ /<(input|textarea|select)/
      first_whitespace = html_tag =~ /\s/
      html_tag[first_whitespace] = " class='#{error_class}' "
    end
    if instance.error_message.kind_of?(Array) && html_tag !~ /label/
      %(#{html_tag} <strong class="error-explanation">&larr; #{instance.error_message.last}</strong>).html_safe
      # or instance.error_message.join(',')
    elsif html_tag !~ /label/
      %(#{html_tag} <strong class="error-explanation">&larr; #{instance.error_message}</strong>).html_safe
    else
      "#{html_tag}".html_safe
    end
  else
    ''
  end
end