module GroupForumsHelper

  def forum_ability
    [['唯讀', 1],['回文', 3],['發文', 7],['修改/刪除', 15],['置頂', 31],['移文', 63]]
  end
  
end
