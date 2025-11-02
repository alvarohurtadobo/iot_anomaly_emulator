import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_anomaly_emulator/common/widgets/responsive.dart';

void main() {
  group('Responsive Widget', () {
    testWidgets('should render desktop version for width >= 1024', (
      tester,
    ) async {
      // Arrange
      const desktopWidget = Text('Desktop');
      const tabletWidget = Text('Tablet');
      const mobileWidget = Text('Mobile');

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(1200, 800)),
            child: Responsive(
              desktop: desktopWidget,
              tablet: tabletWidget,
              mobile: mobileWidget,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Desktop'), findsOneWidget);
      expect(find.text('Tablet'), findsNothing);
      expect(find.text('Mobile'), findsNothing);
    });

    testWidgets('should render tablet version for 640 <= width < 1024', (
      tester,
    ) async {
      // Arrange
      const desktopWidget = Text('Desktop');
      const tabletWidget = Text('Tablet');
      const mobileWidget = Text('Mobile');

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(800, 600)),
            child: Responsive(
              desktop: desktopWidget,
              tablet: tabletWidget,
              mobile: mobileWidget,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Tablet'), findsOneWidget);
      expect(find.text('Desktop'), findsNothing);
      expect(find.text('Mobile'), findsNothing);
    });

    testWidgets('should render mobile version for width < 640', (tester) async {
      // Arrange
      const desktopWidget = Text('Desktop');
      const tabletWidget = Text('Tablet');
      const mobileWidget = Text('Mobile');

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(500, 800)),
            child: Responsive(
              desktop: desktopWidget,
              tablet: tabletWidget,
              mobile: mobileWidget,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Mobile'), findsOneWidget);
      expect(find.text('Desktop'), findsNothing);
      expect(find.text('Tablet'), findsNothing);
    });

    testWidgets('should render desktop when tablet is null', (tester) async {
      // Arrange
      const desktopWidget = Text('Desktop');
      const mobileWidget = Text('Mobile');

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(800, 600)),
            child: Responsive(
              desktop: desktopWidget,
              mobile: mobileWidget,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Desktop'), findsOneWidget);
      expect(find.text('Mobile'), findsNothing);
    });

    testWidgets('should render desktop when mobile is null', (tester) async {
      // Arrange
      const desktopWidget = Text('Desktop');
      const tabletWidget = Text('Tablet');

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(400, 800)),
            child: Responsive(
              desktop: desktopWidget,
              tablet: tabletWidget,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Desktop'), findsOneWidget);
      expect(find.text('Tablet'), findsNothing);
    });

    testWidgets('should render desktop when both tablet and mobile are null', (
      tester,
    ) async {
      // Arrange
      const desktopWidget = Text('Desktop');

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(400, 800)),
            child: Responsive(
              desktop: desktopWidget,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Desktop'), findsOneWidget);
    });

    testWidgets('isDesktop should return true for width >= 1024', (
      tester,
    ) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(1200, 800)),
        child: Builder(
          builder: (context) {
            final isDesktop = Responsive.isDesktop(context);
            return Text('$isDesktop');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('isDesktop should return false for width < 1024', (
      tester,
    ) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(800, 600)),
        child: Builder(
          builder: (context) {
            final isDesktop = Responsive.isDesktop(context);
            return Text('$isDesktop');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('isTablet should return true for 640 <= width < 1024', (
      tester,
    ) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(800, 600)),
        child: Builder(
          builder: (context) {
            final isTablet = Responsive.isTablet(context);
            return Text('$isTablet');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('isTablet should return false for width >= 1024', (
      tester,
    ) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(1200, 800)),
        child: Builder(
          builder: (context) {
            final isTablet = Responsive.isTablet(context);
            return Text('$isTablet');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('isTablet should return false for width < 640', (tester) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(500, 800)),
        child: Builder(
          builder: (context) {
            final isTablet = Responsive.isTablet(context);
            return Text('$isTablet');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('isMobile should return true for width < 640', (tester) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(500, 800)),
        child: Builder(
          builder: (context) {
            final isMobile = Responsive.isMobile(context);
            return Text('$isMobile');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('true'), findsOneWidget);
    });

    testWidgets('isMobile should return false for width >= 640', (
      tester,
    ) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(800, 600)),
        child: Builder(
          builder: (context) {
            final isMobile = Responsive.isMobile(context);
            return Text('$isMobile');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('false'), findsOneWidget);
    });

    testWidgets('edge case: exactly 640 width should return tablet', (
      tester,
    ) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(640, 800)),
        child: Builder(
          builder: (context) {
            final isTablet = Responsive.isTablet(context);
            final isMobile = Responsive.isMobile(context);
            return Text('tablet:$isTablet, mobile:$isMobile');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('tablet:true, mobile:false'), findsOneWidget);
    });

    testWidgets('edge case: exactly 1024 width should return desktop', (
      tester,
    ) async {
      // Arrange
      final widget = MediaQuery(
        data: const MediaQueryData(size: Size(1024, 800)),
        child: Builder(
          builder: (context) {
            final isDesktop = Responsive.isDesktop(context);
            final isTablet = Responsive.isTablet(context);
            return Text('desktop:$isDesktop, tablet:$isTablet');
          },
        ),
      );

      // Act
      await tester.pumpWidget(MaterialApp(home: widget));

      // Assert
      expect(find.text('desktop:true, tablet:false'), findsOneWidget);
    });
  });
}
