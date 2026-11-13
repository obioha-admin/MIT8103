const p4db=db.getSiblingDB('connectsphere_p4_db');
print('Counts and sample schema');
printjson({users:p4db.users.countDocuments({}),posts:p4db.posts.countDocuments({}),events:p4db.activity_events.countDocuments({}),embeddedComments:p4db.posts.aggregate([{$unwind:'$comments'},{$count:'n'}]).toArray()[0]?.n||0});
printjson(p4db.posts.findOne({}, {content:1,authorId:1,comments:1,likedBy:1}));
print('Indexes');printjson(p4db.posts.getIndexes());
