import cv2
import sys

def crop_video(input_path, output_path):
    cap = cv2.VideoCapture(input_path)

    if not cap.isOpened():
        print("Error: Could not open video.")
        return

    frame_width = int(cap.get(3))
    frame_height = int(cap.get(4))

    if frame_width != 768 or frame_height != 256:
        print("Error: Input video dimensions are not 256x768.")
        cap.release()
        return

    crop_x = (frame_width - 256) // 2

    fourcc = cv2.VideoWriter_fourcc(*'XVID')
    out = cv2.VideoWriter(output_path, fourcc, 30.0, (256, 256))

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        cropped_frame = frame[:, crop_x:crop_x+256]
        out.write(cropped_frame)

        cv2.imshow('Cropped Frame', cropped_frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cap.release()
    out.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script_name.py input_video_path output_video_path")
        sys.exit(1)

    input_video_path = sys.argv[1]
    output_video_path = sys.argv[2]
    crop_video(input_video_path, output_video_path)
