# frozen_string_literal: true

module UseCaseResponder
  extend ActiveSupport::Concern

  private

  def render_form_errors(view)
    respond_to do |format|
      format.html do
        render view, status: :unprocessable_entity, layout: !turbo_frame_request?
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "modal",
          template: "#{controller_path}/#{view}",
          layout: false,
          formats: [ :html ]
        ), status: :unprocessable_entity
      end
    end
  end

  def respond_with_success(url:, notice:, action:, record:)
    respond_to do |format|
      format.html { redirect_to url, notice: notice }
      format.turbo_stream { send(:"#{action}_stream_success", record) }
    end
  end

  def create_stream_success(record)
    render_turbo_action(action: :prepend, target: record.model_name.plural, record: record)
  end

  def update_stream_success(record)
    render_turbo_action(action: :replace, target: record, record: record)
  end

  def destroy_stream_success(record)
    render turbo_stream: turbo_stream.remove(record)
  end

  # Orquestra a injeção do Turbo Stream (Agora usando to_partial_path nativo)
  def render_turbo_action(action:, target:, record:)
    render turbo_stream: [
      turbo_stream.send(
        action,
        target,
        partial: record.to_partial_path,
        locals: { record.model_name.element.to_sym => record },
        formats: [ :html ]
      ),
      turbo_stream.update("modal", "")
    ]
  end
end
