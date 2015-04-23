module CampingsHelper
  def area_select(area)
    case area
    when '1' then '北部'
    when '2' then '中部'
    when '3' then '南部'
    when '4' then '東部'
    when '5' then '離島'
    end
  end

  def webmap(gmap)
    web = 'https://www.google.com.tw/maps/place/'
    if /-?\d{1,3}.\d{1,}, ?-?\d{1,3}.\d{1,}/.match(gmap)
      latitude, longitude = gmap.split(/, ?/)
      latitude.to_f >= 0 ? lat_mark = 'N+' : lat_mark = 'S+'
      longitude.to_f >= 0 ? long_mark = 'E' : long_mark = 'W'
      web + dot_min_sec(latitude.to_f.abs) + lat_mark + dot_min_sec(longitude.to_f.abs) + long_mark
    else
      web + gmap
    end
  end

  def dot_min_sec(gps)
    dot = gps.to_i
    min = ((gps - dot).round(6) * 60).to_i
    sec = (((gps - dot).round(6) * 60 - min) * 60).to_s[0, 6]
    dot.to_s + '°' + min.to_s + "'" + sec + '"'
  end
end
