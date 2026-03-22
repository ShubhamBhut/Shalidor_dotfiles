import datetime
import json

now = datetime.datetime.now()

start_day = now.replace(hour=0, minute=0, second=0, microsecond=0)
end_day = start_day + datetime.timedelta(days=1)
day_pct = (now - start_day).total_seconds() / (end_day - start_day).total_seconds()

start_week = start_day - datetime.timedelta(days=now.weekday())
end_week = start_week + datetime.timedelta(days=7)
week_pct = (now - start_week).total_seconds() / (end_week - start_week).total_seconds()

start_year = now.replace(month=1, day=1, hour=0, minute=0, second=0, microsecond=0)
end_year = now.replace(year=now.year+1, month=1, day=1, hour=0, minute=0, second=0, microsecond=0)
year_pct = (now - start_year).total_seconds() / (end_year - start_year).total_seconds()

def make_bar(pct, length=12):
    filled = int(pct * length)
    empty = length - filled
    
    filled_line = "━" * filled
    empty_line = "━" * empty
    
    return f"<span color='#ea9a97'>{filled_line}</span><span color='#45475a'>{empty_line}</span>"

day_spent = day_pct * 100
week_spent = week_pct * 100
year_spent = year_pct * 100

text = f" {make_bar(day_pct)} <span color='#e0def4'>{day_spent:.0f}%</span> "

tooltip = f"<span color='#ea9a97'>⏳ Time Spent</span>\n\nDay:   {day_spent:.1f}%\nWeek:  {week_spent:.1f}%\nYear:  {year_spent:.1f}%"

print(json.dumps({
    "text": text,
    "tooltip": tooltip,
    "class": "timeprogress"
}))
