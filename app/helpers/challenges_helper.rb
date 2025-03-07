# frozen_string_literal: true

module ChallengesHelper
  def challenge_solved?(challenge)
    solved_challenges.include?(challenge.id)
  end

  def challenge_status_button_tag(challenge)
    return activate_challenge_button(challenge) unless challenge.active?

    deactivate_challenge_button(challenge)
  end

  def ctf_start_time
    Time.zone.parse(CtfSetting.find_by(key: 'start_time')&.value).httpdate
  end

  def time_now
    Time.zone.now.httpdate
  end

  private

  def deactivate_challenge_button(challenge)
    challenge_status_button(
      'Deactivate challenge',
      'btn-danger',
      deactivate_admin_category_challenge_path(challenge.category, challenge)
    )
  end

  def activate_challenge_button(challenge)
    challenge_status_button(
      'Activate challenge',
      'btn-success',
      activate_admin_category_challenge_path(challenge.category, challenge)
    )
  end

  def challenge_status_button(btn_name, btn_color, path)
    link_to btn_name,
            path,
            class: "btn #{btn_color}",
            method: :patch
  end

  def solved_challenges
    @solved_challenges ||= Submission.where(team: current_user&.team, valid_submission: true).pluck(:challenge_id)
  end
end
