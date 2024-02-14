/**
 * @file
 * @brief Public C interface for the library.
 *
 * @copyright Copyright (c) 2023-2024 theComputeKid
 */
#pragma once

#ifdef __cplusplus
/** @brief Macro for enabling/disabling extern linkage. */
#	define CONV_EXTERN_C extern "C"
#else
/** @brief Macro for enabling/disabling extern linkage. */
#	define CONV_EXTERN_C
#endif

#ifdef _WIN32
#	ifdef CONV_EXPORT
/** @brief Macro for exporting symbols for Windows. */
#		define CONV_LINK CONV_EXTERN_C __declspec(dllexport)
#	else
/** @brief Macro for importing symbols for Windows. */
#		define CONV_LINK CONV_EXTERN_C __declspec(dllimport)
#	endif
#else
#	ifdef CONV_EXPORT
/** @brief Macro for exporting symbols for Unix. */
#		define CONV_LINK CONV_EXTERN_C __attribute__((visibility("default")))
#	else
/** @brief Macro for importing symbols for Unix. Empty. */
#		define CONV_LINK CONV_EXTERN_C
#	endif
#endif

/**
 * @brief Return the major version of the project.
 * @return the major version of the project.
 */
CONV_LINK int convVersionMajor(void);

/**
 * @brief Return the minor version of the project.
 * @return the minor version of the project.
 */
CONV_LINK int convVersionMinor(void);

/**
 * @brief Return the patch version of the project.
 * @return the patch version of the project.
 */
CONV_LINK int convVersionPatch(void);
