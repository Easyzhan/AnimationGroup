# AnimationGroup
今天群里有人问我一个组合动画怎么实现
最近在看核心动画,这个动画组就显得so简单了
注意:如果你需要做角度转换
CATransform3DMakeRotation将避免不了要用到三维坐标
z轴垂直于屏幕,而这里的角度不用说了,xyz则表示绕着哪个轴转
范围都是-1到1之间
    
      /* Returns a transform that rotates by 'angle' radians about the vector
    * '(x, y, z)'. If the vector has length zero the identity transform is
    * returned. */

    CA_EXTERN CATransform3D CATransform3DMakeRotation (CGFloat angle, CGFloat x,
    CGFloat y, CGFloat z)
    CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
    
![image](https://ww1.sinaimg.cn/large/006tNbRwgy1fd69utboegg30ai0inqax.gif)
