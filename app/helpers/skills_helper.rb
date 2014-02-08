module SkillsHelper
  def career?(character_skill)
    if character_skill.career?
      tag(:i, class: "icon icon-check").html_safe
    else
      tag(:i, class: "").html_safe
    end
  end
end
