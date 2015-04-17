module SchedulesHelper
  def time_set(time)
    return unless time
    hh = time.strftime('%H').to_i
    mm = time.strftime('%M').to_i

    case hh
    when 0..8 then x = '早上'
    when 9..11
      mm > 30 && hh == 11 ? x = '中午' : x = '上午'
    when 12..17
      mm < 30 && hh == 12 ? x = '中午' : x = '下午'
    when 18..23 then x = '晚上'
    end

    time.strftime("%Y年%-m月%e日 #{x}%l點%M")
  end
end
