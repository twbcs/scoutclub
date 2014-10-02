module GroupsHelper
  def ability(forum_ability)
    case forum_ability
    when 1
      '唯讀'
    when 3
      '回文'
    when 7
      '發文'
    when 15
      '修改/刪除'
    when 31
      '置頂'
    when 63
      '移文'
    end
  end
end
