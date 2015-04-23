module GroupsHelper
  def ability(forum_ability)
    case forum_ability
    when 1 then '唯讀'
    when 3 then '回文'
    when 7 then '發文'
    when 15 then '修改/刪除'
    when 31 then '置頂'
    when 63 then '移文'
    end
  end
end
