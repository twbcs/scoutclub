module SchedulesHelper
  def time_set(time)
    if time
      hh = time.strftime("%H").to_i
      mm = time.strftime("%M").to_i
      h = time.strftime("%I").to_i
      g = time.strftime("%m").to_i
      d = time.strftime("%d").to_i
      case hh
      when 0..8
        x = '早上'
      when 9..11
        if mm > 30 && hh == 11
          x = '中午'
        else
          x = '上午'
        end
      when 12..17
        if mm < 30 && hh == 12
          x = '中午'
        else
          x = '下午'
        end
      when 18..23
        x = '晚上'
      end

      xtime = time.strftime("%Y年") + g.to_s + '月' + d.to_s + '日 ' + x +
                                    h.to_s + '點' + time.strftime("%M")
    end
  end
end
