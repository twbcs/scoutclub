# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create(name: 'Chicago' , name: 'Copenhagen' )
#   Mayor.create(name: 'Emanuel', city: cities.first)

Group.create(name: '全站管理者', admin: true)
Group.create(name: '校內管理組', admin: true)
Group.create(name: '一年級', admin: false)
Group.create(name: '二三年級', admin: false)
Group.create(name: '畢業夥伴', admin: false)
Group.create(name: '一般使用者', admin: false)
Group.create(name: '團長', admin: false)

ForumKind.create(title: '交流區', description: '通用區')
ForumKind.create(title: '團務區', description: '團內事務討論區')
ForumKind.create(title: '網站事務區', description: '網站發生的疑難雜症都可在這區發問')

Forum.create(title: '活動通知子板', description: '諸如各校團慶等活動通知邀請',
             forum_kind_id: 1, public_at: true)
Forum.create(title: '校內討論子版', description: '',
             forum_kind_id: 2, public_at: false)
Forum.create(title: '校內幹部子版', description: '',
             forum_kind_id: 2, public_at: false)
Forum.create(title: '團務交流子板', description: '',
             forum_kind_id: 2, public_at: false)
Forum.create(title: '畢業夥伴子板', description: '',
             forum_kind_id: 2, public_at: false)
Forum.create(title: '權限申請子版', description: '申請永久子板或辦理活動臨時討論子版或其他需求。',
             forum_kind_id: 3, public_at: true)
Forum.create(title: '網站問題子板', description: '網站事務子版',
             forum_kind_id: 3, public_at: true)
Forum.create(title: '網站事務子版', description: '',
             forum_kind_id: 3, public_at: false)
Forum.create(title: '閒話家常子版', description: '任何主題都可聊',
             forum_kind_id: 1, public_at: true)

GroupForum.create(group_id: 1, forum_id: 1, level: 63)
GroupForum.create(group_id: 1, forum_id: 9, level: 63)
GroupForum.create(group_id: 1, forum_id: 4, level: 63)
GroupForum.create(group_id: 1, forum_id: 5, level: 63)
GroupForum.create(group_id: 1, forum_id: 6, level: 63)
GroupForum.create(group_id: 1, forum_id: 7, level: 63)
GroupForum.create(group_id: 1, forum_id: 8, level: 63)
GroupForum.create(group_id: 2, forum_id: 1, level: 63)
GroupForum.create(group_id: 2, forum_id: 9, level: 63)
GroupForum.create(group_id: 2, forum_id: 2, level: 63)
GroupForum.create(group_id: 2, forum_id: 3, level: 63)
GroupForum.create(group_id: 2, forum_id: 4, level: 31)
GroupForum.create(group_id: 2, forum_id: 6, level: 31)
GroupForum.create(group_id: 2, forum_id: 7, level: 63)
GroupForum.create(group_id: 2, forum_id: 8, level: 7)
GroupForum.create(group_id: 5, forum_id: 1, level: 7)
GroupForum.create(group_id: 5, forum_id: 9, level: 7)
GroupForum.create(group_id: 5, forum_id: 4, level: 7)
GroupForum.create(group_id: 5, forum_id: 5, level: 7)
GroupForum.create(group_id: 5, forum_id: 6, level: 7)
GroupForum.create(group_id: 5, forum_id: 7, level: 7)
GroupForum.create(group_id: 6, forum_id: 1, level: 7)
GroupForum.create(group_id: 6, forum_id: 9, level: 7)
GroupForum.create(group_id: 4, forum_id: 1, level: 7)
GroupForum.create(group_id: 4, forum_id: 9, level: 7)
GroupForum.create(group_id: 4, forum_id: 2, level: 7)
GroupForum.create(group_id: 4, forum_id: 4, level: 7)
GroupForum.create(group_id: 4, forum_id: 6, level: 7)
GroupForum.create(group_id: 4, forum_id: 7, level: 7)
GroupForum.create(group_id: 6, forum_id: 6, level: 7)
GroupForum.create(group_id: 6, forum_id: 7, level: 7)
GroupForum.create(group_id: 3, forum_id: 1, level: 7)
GroupForum.create(group_id: 3, forum_id: 9, level: 7)
GroupForum.create(group_id: 3, forum_id: 2, level: 7)
GroupForum.create(group_id: 3, forum_id: 6, level: 7)
GroupForum.create(group_id: 3, forum_id: 7, level: 7)
GroupForum.create(group_id: 7, forum_id: 1, level: 7)
GroupForum.create(group_id: 7, forum_id: 9, level: 7)
GroupForum.create(group_id: 7, forum_id: 2, level: 7)
GroupForum.create(group_id: 7, forum_id: 3, level: 7)
GroupForum.create(group_id: 7, forum_id: 4, level: 7)
GroupForum.create(group_id: 7, forum_id: 6, level: 7)
GroupForum.create(group_id: 7, forum_id: 7, level: 7)
GroupForum.create(group_id: 7, forum_id: 8, level: 7)

DoingKind.create(title: '全國大露營')
DoingKind.create(title: '授課')
