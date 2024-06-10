import 'package:blog_mobile/api/auth/auth_service.dart';
import 'package:blog_mobile/models/post.dart';
import 'package:blog_mobile/models/user.dart';
import 'package:blog_mobile/view/home/components/post_component.dart';

class PostConvert {
  static Future<List<PostComponent>> convertPostApi(List<dynamic> posts) async{
    List<PostComponent> cardsPosts = [];
    for (var post in posts) {
      final Post auxPost = Post(post['id'], post['body'], post['tags'],
          post['reactions'], post['views'], post['userId']);

      if(auxPost.getUserId != null){
        final User? user = await AuthService.userMakedPost(auxPost.getUserId.toString());
        if(user != null){
          PostComponent auxCardPost = PostComponent(post: auxPost, user: user);
          cardsPosts.add(auxCardPost);
        }
      }
    }
    return cardsPosts;
  }
}
