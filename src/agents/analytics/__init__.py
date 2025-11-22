"""Analytics Agents Package.

Module: src.agents.analytics
Author: nguyễn Nhật Quang
Created: 2025-11-21

Description:
    Analytical processing agents for traffic monitoring including
    computer vision analysis, accident detection, congestion detection,
    and pattern recognition.
"""

from .cv_analysis_agent import (
    CVAnalysisAgent,
    CVConfig,
    YOLOv8Detector,
    ImageDownloader,
    MetricsCalculator,
    NGSILDEntityGenerator,
    Detection,
    ImageAnalysisResult,
    TrafficMetrics,
    DetectionStatus
)

__all__ = [
    'CVAnalysisAgent',
    'CVConfig',
    'YOLOv8Detector',
    'ImageDownloader',
    'MetricsCalculator',
    'NGSILDEntityGenerator',
    'Detection',
    'ImageAnalysisResult',
    'TrafficMetrics',
    'DetectionStatus'
]
