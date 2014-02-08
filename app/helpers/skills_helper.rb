module SkillsHelper
  def career?(skill, character)
    if character.career_skills.include?(skill)
      tag(:i, class: "icon icon-check").html_safe
    else
      tag(:i, class: "").html_safe
    end
  end
end
