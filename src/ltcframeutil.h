#ifndef LTCFRAMEUTIL_H
#define LTCFRAMEUTIL_H

#include <stdio.h>
#include <ltc.h>

#ifdef __cplusplus
extern "C" {
#endif

int cmp_ltc_frametime(LTCFrame *a, LTCFrame *b, int what);
LIBLTC_API int detect_fps(int *fps, LTCFrameExt *frame, SMPTETimecode *stime, FILE *output);
LIBLTC_API int detect_discontinuity(LTCFrameExt *frame, LTCFrameExt *prev, int fps, int use_date, int fuzzyfps);

#ifdef __cplusplus
}
#endif

#endif
