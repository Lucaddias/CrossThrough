// PythonShim.h — Python C-API declarations for CrossThrough
#ifndef PythonShim_h
#define PythonShim_h

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _object PyObject;
typedef struct _is PyInterpreterState;
typedef struct _ts PyThreadState;

typedef enum { PyGILState_LOCKED, PyGILState_UNLOCKED } PyGILState_STATE;

extern int Py_NoUserSiteDirectory;
extern void Py_InitializeEx(int);
extern void Py_SetProgramName(const wchar_t *);
extern wchar_t *Py_DecodeLocale(const char *, size_t *);
extern void PyMem_RawFree(void *);
extern void PySys_SetArgvEx(int, wchar_t **, int);
extern PyObject *PyUnicode_FromString(const char *);
extern PyObject *PyImport_ImportModule(const char *);
extern int PyObject_SetAttrString(PyObject *, const char *, PyObject *);
extern int PyRun_SimpleFileExFlags(FILE *, const char *, int, void *);
extern void PyErr_Print(void);
extern PyThreadState *PyEval_SaveThread(void);
extern PyGILState_STATE PyGILState_Ensure(void);
extern void PyGILState_Release(PyGILState_STATE);
extern void _Py_Dealloc(PyObject *);

#ifdef __cplusplus
}
#endif

// Forward declare PyObjC bridge classes
@class BottleCollection;
@class BottleWrapper;
@class InstallTask;
@class AIETask;
@class RatingUtils;
@class TargetBottle;
@class WineApplicationController;
@class SFAuthorization;

#endif /* PythonShim_h */
