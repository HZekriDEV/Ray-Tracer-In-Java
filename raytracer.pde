public void setup() {
  size(800, 600, P3D);
}

void draw() {
  background(0);

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      // Calculate the ray direction
      PVector rayDir = new PVector((x - width / 2) / (float) width, (y - height / 2) / (float) height, -1);
      rayDir.normalize();

      // Create a ray object
      Ray ray = new Ray(new PVector(0, 0, 0), rayDir);

      // Calculate intersections
      boolean hitSphere = sphereIntersection(new PVector(0, 0, -50), 10, ray);

      // Determine the pixel color
      if (hitSphere) {
        set(x, y, color(0, 255, 0));
      } else {
        set(x, y, color(0));
      }
    }
  }

  // Save the rendered image
  save("rendered_image.png");
  noLoop();
}  

boolean sphereIntersection(PVector sphereCenter, float sphereRadius, Ray ray) {
  PVector oc = PVector.sub(ray.origin, sphereCenter);
  float a = ray.direction.dot(ray.direction);
  float b = 2.0 * oc.dot(ray.direction);
  float c = oc.dot(oc) - sphereRadius * sphereRadius;
  float discriminant = b * b - 4 * a * c;
  return (discriminant > 0);
}

float closestIntersection(float[] intersections) {
  float closest = Float.MAX_VALUE;
  for (float t : intersections) {
    if (t > 0 && t < closest) {
      closest = t;
    }
  }
  return closest;
}
