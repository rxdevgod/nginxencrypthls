# bash renderHls.sh ./input/480p.mp4 ./input/720p.mp4 ./input/1080p.mp4 ./output/beach ./tier01.keyinfo

# 480p
profile1="${1}"
# 720p
profile2="${2}"
# 1080p
profile3="${3}"

# Destination
destination="${4}"
# Key: empty means not encrypt
key="${5}"

# GENERATE HLS WITH ENCRYPT
# ffmpeg -y -i "./input/input.mp4" -c copy -f hls -hls_time 6 -hls_list_size 0 -hls_key_info_file tier01.keyinfo -hls_playlist_type vod -hls_segment_filename "./output/480p_%d.ts" "output/480p.m3u8"
mkdir -p $destination
if [ -z "$5" ]
then
  ffmpeg -y \
    -i "$profile1" -c copy -f hls -hls_time 6 -hls_list_size 0 -hls_playlist_type vod \
    -hls_segment_filename "$destination/480p_%d.ts" "$destination/480p.m3u8"

  ffmpeg -y \
    -i "$profile2" -c copy -f hls -hls_time 6 -hls_list_size 0 -hls_playlist_type vod \
    -hls_segment_filename "$destination/720p_%d.ts" "$destination/720p.m3u8"

  ffmpeg -y \
    -i "$profile3" -c copy -f hls -hls_time 6 -hls_list_size 0 -hls_playlist_type vod \
    -hls_segment_filename "$destination/1080p_%d.ts" "$destination/1080p.m3u8"
else
  ffmpeg -y \
    -i "$profile1" -c copy -f hls -hls_time 6 -hls_list_size 0 -hls_key_info_file tier01.keyinfo -hls_playlist_type vod \
    -hls_segment_filename "$destination/480p_%d.ts" "$destination/480p.m3u8"

  ffmpeg -y \
    -i "$profile2" -c copy -f hls -hls_time 6 -hls_list_size 0 -hls_key_info_file tier01.keyinfo -hls_playlist_type vod \
    -hls_segment_filename "$destination/720p_%d.ts" "$destination/720p.m3u8"

  ffmpeg -y \
    -i "$profile3" -c copy -f hls -hls_time 6 -hls_list_size 0 -hls_key_info_file tier01.keyinfo -hls_playlist_type vod \
    -hls_segment_filename "$destination/1080p_%d.ts" "$destination/1080p.m3u8"
fi


# MAKE PLAYLIST
touch "$destination/playlist.m3u8"
echo "#EXTM3U" > "$destination/playlist.m3u8"
echo "#EXT-X-VERSION:3" >> "$destination/playlist.m3u8"
echo "#EXT-X-STREAM-INF:BANDWIDTH=1400000,RESOLUTION=842x480" > "$destination/playlist.m3u8"
echo "480p.m3u8" >> "$destination/playlist.m3u8"
echo "#EXT-X-STREAM-INF:BANDWIDTH=2800000,RESOLUTION=1280x720" > "$destination/playlist.m3u8"
echo "720p.m3u8" >> "$destination/playlist.m3u8"
echo "#EXT-X-STREAM-INF:BANDWIDTH=5000000,RESOLUTION=1920x1080" > "$destination/playlist.m3u8"
echo "1080p.m3u8" >> "$destination/playlist.m3u8"
