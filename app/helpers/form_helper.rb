module FormHelper
  def input(f, field, opts = {})
    content_tag(:div, class: 'form-group') do
      concat f.label(field, class: 'col-xs-4 control-label')
      concat(
        content_tag(:div, class: 'col-xs-8') {
          concat build_input(f, field, opts)
          concat \
            content_tag(
              :div,
              opts[:help],
              class: 'help-block') if opts[:help]
        }
      )
    end
  end

  def check_box_group(f, label, boxes)
    render 'form_helper/check_box_group',
      f: f,
      label: label,
      boxes: boxes
  end

  def devise_errors
    content_tag :div, devise_error_messages!, class: 'col-xs-12'
  end

  private
  def type_for(obj, field)
    case obj.class.columns_hash[field.to_s].type
    when :string
      :text_field
    else
      :text_field
    end
  end

  def build_input(f, field, opts)
    type = opts[:type] || type_for(f.object, field)

    case type
    when :select, :time_zone_select
      f.send type, field, opts[:options],
        { include_blank: opts[:include_blank] },
        { class: 'form-control' }
    else
      f.send type, field, class: 'form-control', **(opts[:input_args] || {})
    end
  end
end
