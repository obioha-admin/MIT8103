// Safe repeatable demonstration: inserted document is removed at the end.
const p4db=db.getSiblingDB('connectsphere_p4_db');
const author=p4db.users.findOne({username:'p4_user_001'});
if(!author) throw Error('Seed data missing; run 00 first');
const r=p4db.posts.insertOne({authorId:author._id,content:'Temporary CRUD demonstration',visibility:'private',createdAt:new Date(),comments:[],likedBy:[]});
print('CREATE');printjson(p4db.posts.findOne({_id:r.insertedId}));
p4db.posts.updateOne({_id:r.insertedId},{$set:{content:'Updated CRUD demonstration'}});
print('UPDATE');printjson(p4db.posts.findOne({_id:r.insertedId}));
p4db.posts.deleteOne({_id:r.insertedId});
print('DELETE verified');printjson({remaining:p4db.posts.countDocuments({_id:r.insertedId})});
